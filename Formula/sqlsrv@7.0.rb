# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT70 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.9.0.tgz"
  sha256 "0a108e0408e8b984e5ae8bc52824ed32872d72e3a571cd2a5d2b63b200215ab3"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "6773e6d67cd0522f89aa9f061ca58856267ebd6414f33ed427c40c362f2fdaed"
    sha256 cellar: :any,                 arm64_ventura:  "8dcbee87ec947da9d1612908a5899bc19089ca462ac236ba8f6343507e5c2f58"
    sha256 cellar: :any,                 arm64_monterey: "6fe55a0946635a7befe7102c29c988cd50b7ab851152d85dcfdba70265bb6102"
    sha256 cellar: :any,                 arm64_big_sur:  "c78e51788cb3871aa1d488ac8b75ff100f09f122fee202057aea09f9d0a836b2"
    sha256 cellar: :any,                 sonoma:         "b5d3668890f02a6f5e514f25e1fef422e1666c14b66949c80cb04f0ccaccea17"
    sha256 cellar: :any,                 ventura:        "4a568f361a9bab1f71f307e4ec83e5cfc0a71b013530ccc65c85175eb7cc9235"
    sha256 cellar: :any,                 monterey:       "838a322938257fca94725db4acce1f0a1e7aa6d84bbc4b4150337833524cdb1b"
    sha256 cellar: :any,                 big_sur:        "3ce07897920891245223542b9897354a7e20f8eb28614a677cc381f387b972fe"
    sha256 cellar: :any,                 catalina:       "d5e99b31b184538deb11dff51cfcf3801f09ab401b3c2b51ff9e64b08b74fa93"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "fc001ed257224c97e9dd48ae8423ca391d3c5334dd8b44858e418ae1eb6363a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b4ea1a82350f55b0f4f48ab924b8800b25801fd5101f01eeda473c7d1470ecbe"
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
