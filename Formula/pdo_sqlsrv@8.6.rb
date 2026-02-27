# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.0.tgz"
  sha256 "efa859bcc48d97f25268dbdebf1db25f25610d7fa36b3ee91073c1c99411e24c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "06a88d8ed917a84914195aac628705ade10ac6a49d7101243e36178895be5156"
    sha256 cellar: :any,                 arm64_sequoia: "3ab9d35b1ff66e2b9486f9f095926d2f3e44cee9115e277b5913a7998d4ad1aa"
    sha256 cellar: :any,                 arm64_sonoma:  "75575e650527ba124ffa7b7c8fcc5705f933f684123540c1f3a23d36044bc509"
    sha256 cellar: :any,                 sonoma:        "cb92fa92bf227ecb3d1855dd228532de63b3fb3745783daaee0e3a140b0881ed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "33c8d4f52da47087c49a7e888b3f911c254efc774dbf997b5b3d77d7cdbf029e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e4144e049e6c69e81b9be8ec09a78fdd9f358a367d410b80b2d51d6a5539fd8"
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
