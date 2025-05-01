class Merge < Formula
    desc "Recursively merge all files in a folder with filename headers"
    homepage "https://github.com/dhivatiradika/merge"
    url "https://github.com/dhivatiradika/merge/archive/v0.2.0.tar.gz"
    sha256 "a2a8d3e6116523662d4eabaf2ca7c496f7126b107bb26dd086a1a817225f7821"
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
  