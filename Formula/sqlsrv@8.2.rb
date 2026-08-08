# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT82 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.3.tgz"
  sha256 "1c3092ca793bb67002ca022c412aacabb79a3297ee7005e3b7cc91b1e7166d22"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "f6e1be594d21f7faa2626b6adca92e70ae3644264bd9ba81120f65b4a9e1a57b"
    sha256 cellar: :any, arm64_sequoia: "9920d5749058e2510d1009e9148b254d1bb3577f6ed50c38363f6b603ddfa1ad"
    sha256 cellar: :any, arm64_sonoma:  "d462280fa12a623fcc56775d34f21477697623fe8706ea84a27e398acadf72f5"
    sha256 cellar: :any, sonoma:        "8c83d0a109cbd400cb9542ef0d63b44317068198391116a5f4731d49b079321c"
    sha256 cellar: :any, arm64_linux:   "a6fefab6488a4ba2dc1a55100622126874e536e2f54e522e1447d5cab3bb5056"
    sha256 cellar: :any, x86_64_linux:  "3e33cee544e645bc4f8b6a8cd20652c64eea33b24a4f30c48506df001c189610"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
