# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT84 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8df86d0808d0f100442658aea960f19e375ba6f350c9944e2a37e9e71ceb0e22"
    sha256 cellar: :any,                 arm64_ventura:  "aa3bac9f1a1ba582e2a2e66ec132473aba08951bc2e136ab9bdb2339c8380ec5"
    sha256 cellar: :any,                 arm64_monterey: "987f958edcd0d1c994ed30c0726398af12dc996322e259561ed57322ca61744f"
    sha256 cellar: :any,                 ventura:        "0250ab6fe0d3fb8d51fc5f65e809d89b4bcc5303c1cb4a4352cbdaa66ba570be"
    sha256 cellar: :any,                 monterey:       "b09cb71b00890f4ad9d87c70dcc17b40088d3cac2372ef0433633e718d7bfecb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f49ab6bcbbe7779231aae889c2e60a3bdfc12d16adc6f2c6c91055f7dbc32a7e"
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
