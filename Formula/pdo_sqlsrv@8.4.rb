# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.12.0.tgz"
  sha256 "22f0cb17b45f0deccd0bba072ee0085ff4094cd6ee2acc26f7f924975ef652c6"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9a847d3322968f3f9010edb15bb455de51c134c687014afda6000093da119f46"
    sha256 cellar: :any,                 arm64_ventura:  "0d33bca59309602d970d69dedf1d591cb0dd49be6a361808e395c4cb96b08a4d"
    sha256 cellar: :any,                 arm64_monterey: "26cdd478c777cc1c76e17f0e3e8e5e8a3f77949f42486232c99ddd9633624210"
    sha256 cellar: :any,                 ventura:        "c1c2aec9b0fd669eab1c8cbff87b3f8002a1b06d12aa0a77ea3997a9a5fbbf92"
    sha256 cellar: :any,                 monterey:       "c42d885cdf16b5860cae9348f453e40509bf8d2dab54fb14fa169c535d7b3b1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77c3ff012e7f286bd0ce5037ddd44516270a50e46d53b79e6ba1e1bcfe0b33f5"
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
