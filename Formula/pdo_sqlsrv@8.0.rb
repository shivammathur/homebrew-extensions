# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7f934d57da7d91aa292287c4f060369721cab9e644fb928f7c6d4854fe7100f6"
    sha256 cellar: :any,                 arm64_sequoia: "1b6a5122285159fa6e330c9dfac1d22a056a02a29ef74f7c68b66e273322b230"
    sha256 cellar: :any,                 arm64_sonoma:  "4d3aa0b6c7c0bf67a24fd7956bc302a21d88027c29a620a419fc4e58323417da"
    sha256 cellar: :any,                 sonoma:        "cff5544e33357b62e4ce5aadb95162e6b35fd284e961fe211cd95679678b80bb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bdc69a9bd8281a2e6ccce6ff80f57e678bac8dc4eadb74661b8529a668038083"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "456a67e1dd94f3740cc7f26b3611828ce493612b6096780d7893aa60ce39c227"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
