# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "95eef138d52eccbf478f9c6be1b7f31b528b846f5e0172e2905a48e39420848e"
    sha256 cellar: :any,                 arm64_monterey: "85993c5b8326c6bce3142455580930a04a1600ba91ed9e742c21cff741ee7c42"
    sha256 cellar: :any,                 arm64_big_sur:  "06c2a531022ce94fc984ed35d0beea4fbb7a6ffa56cfdbb399412dd488501351"
    sha256 cellar: :any,                 ventura:        "1425aa167ee35bf8cbd095d3d8b300865a5e100933ecd4c1fa1a71be38e20127"
    sha256 cellar: :any,                 monterey:       "6e0ca40cb7ccc3a7795520cbf0f414da0a96b73e88a74204fcfe1d87e5d59b01"
    sha256 cellar: :any,                 big_sur:        "f08e410517493761eea4d2f06e52f8baf8f974117a9c87cc9e3cbcf1ef7133ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d9b5427fc8a2a4685418c7470586a79d25f7344c016e3912d2d908a50a3104a"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
