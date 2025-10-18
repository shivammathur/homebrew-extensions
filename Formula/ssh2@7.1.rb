# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "c91ee8358b38cec4a1f5274f0b95b0ebf365e178ffe00cd3fcf7860501fb6510"
    sha256 cellar: :any,                 arm64_sonoma:   "6e88bd260b9d4e7d6a6d0a564a0454b6ca7707b4b9fe03d128f4ae7a07d168b9"
    sha256 cellar: :any,                 arm64_ventura:  "808fb1850e640f18c5f408e2be007c0e0bf847900405b29b6e380f45967e5a65"
    sha256 cellar: :any,                 arm64_monterey: "496c9c3550e1eabcbe525635503f2714ae7e669dbc96f29410e862395ab14b6b"
    sha256 cellar: :any,                 ventura:        "ca5329e5d63340452a19f64fa8f4bf5731d45ec854a13ab41d1e72a696ee669e"
    sha256 cellar: :any,                 monterey:       "423a763162ea240398435b8078d8c38dce6e9686ec81ac4ec788cd61161695b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "09939ee32e9d1400dd1084bcab1a01693dd2106c9299531a5743677b3e86da0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f621349678b3c159743e47bb71618d6974c7ec18c4b1d6d71dc3d2fbb3921a2"
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
