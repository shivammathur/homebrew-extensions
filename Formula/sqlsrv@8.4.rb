# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT84 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.1.tgz"
  sha256 "7c4ea8f25ebbc8999084239e7e0ef75315097e013df0e290fcef76c3d977b9d8"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "b2e8ba795731f7bdec8224035f5b7f3f4250f96726ea5f798ee69b2091f8f12c"
    sha256 cellar: :any,                 arm64_sequoia: "c25eb1e3a6b99d7b0acfd41694376a3bed86383e0d2900885f46ce8d06074a21"
    sha256 cellar: :any,                 arm64_sonoma:  "c87c8fc6e54b3448df9154374911af427dc8a8631d00cb85431da4d91e9330f8"
    sha256 cellar: :any,                 sonoma:        "c55f2dd88d7499d91e289ceb634015bc104170456e9fe026bcce2a1174d0b0db"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "11ae19d2dad7fa5bcd79309b5e7e0d5ea3c5930d725b1bb21e2b3a80bbcdf83d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0b7ccd48df5bb2f67db02506e4351307796d8f97579b2a28297f49b78182682d"
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
