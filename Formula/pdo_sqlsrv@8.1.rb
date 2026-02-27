# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "af8600e2d6e03bc57cd9a3860ba69efc864fba11afec338d82f5fb10c624abf3"
    sha256 cellar: :any,                 arm64_sequoia: "0292edb74d39f314995ef0a5c8a3bdfe0ccfd72d745bd42cb4b78a84bbd5ccf0"
    sha256 cellar: :any,                 arm64_sonoma:  "462d0b4dde4ef004a8dd19432849f37a1db971e530e9ec0c242e7e30a342b783"
    sha256 cellar: :any,                 sonoma:        "1dfb6de6d680bc94d5743ca98013951805272b1ef78a8225610a147a679b9c91"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1019827339976064fb00af8b74a85c8eb85e6b8d91913a2dc32b6d61a7202e51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b1515aff1c8211b810d2d10eb8355ad44852acb748b186cd2ee780879ebbead"
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
