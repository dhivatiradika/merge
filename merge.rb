class Merge < Formula
    desc "Recursively merge all files in a folder with filename headers"
    homepage "https://github.com/dhivatiradika/merge"
    url "https://github.com/dhivatiradika/merge/archive/v0.1.0.tar.gz"
    sha256 "6729c927081a0d2646397715cdf94b9f2a61ec311fb1bcbb9e9cf2dbaed3b71e"
    license  "MIT"
  
    def install
      # install the script as `merge`
      bin.install "merge.sh" => "merge"
    end
  
    test do
      # create a sample file
      (testpath/"a.txt").write "hello"
      # run merge in copy-only mode and verify it outputs our header+content
      output = pipe_output("#{bin}/merge -c #{testpath}")
      assert_match "=== a.txt ===", output
      assert_match "hello", output
    end
  end
  