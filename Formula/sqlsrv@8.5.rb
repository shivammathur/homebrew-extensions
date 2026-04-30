# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT85 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.13.1.tgz"
  sha256 "7c4ea8f25ebbc8999084239e7e0ef75315097e013df0e290fcef76c3d977b9d8"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "dc50952cc4ee05d73712599ed1f891a18356fc39eaa64659f0dbf08b21e075bb"
    sha256 cellar: :any,                 arm64_sequoia: "7b7a3763245cd3b987dfdd13e09217f9e372d55738ecb01eccfede526b5dd2c1"
    sha256 cellar: :any,                 arm64_sonoma:  "784dec31c2ca8d496d4e4b6b303f55af0efbf36d4b148ae148c6c8662f26cc60"
    sha256 cellar: :any,                 sonoma:        "aca827a1f870dbfeae06046b79e3d64ded431efb4aa4f2b8491ff4119dc9123b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b51d7c4fc10e79bcbf9c2ef6a44aaeabf2718937216dda40abb8ccbfbbad818d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a4b9f7afc1c256e5830aed44b306ce0531a7aa43caed1b92f4bd807f313103e"
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
