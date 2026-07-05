# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8fd72c8651913370c98aa8f3b13dc3bc8484b7408115b6fcfb3640dc561e65ed"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7fc9baf5e769bc49a92beda13d4be27c48b089587703258e08fca68b51b1a9fc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c8e7e1c8cf2cb8b16c410d0e9d0a2f1e2821d3d92eff9f0801abe35d77754402"
    sha256 cellar: :any_skip_relocation, sonoma:        "0269b9a11498895d9550e99a6bcc4acd8093d16db0093db44e6d72bc82fa2d76"
    sha256 cellar: :any,                 arm64_linux:   "f935b23e7ac47ce80d21c3eb4886bfb06b54428e909a45f23dd7e38dd2c5cbbc"
    sha256 cellar: :any,                 x86_64_linux:  "9603bd7db98049c4ab1fd6a097bd8bbfb136dd9c1baa557c6d45dda2bb12f78e"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
