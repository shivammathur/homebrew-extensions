# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT85 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  revision 1
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4ee985b1b5bad987c880314ac9d6f5f86a05b4a39c05487a40e0d1c41fe8199d"
    sha256 cellar: :any,                 arm64_sequoia: "f6b97915f9431c0e378263e2ccabc7d32fbed1289a78d30b6fc22736b6928ebf"
    sha256 cellar: :any,                 arm64_sonoma:  "7d669a2e1b1be98925adf7599b85ebbd5fa85e3af5c6fc090706c5b1502e09ce"
    sha256 cellar: :any,                 sonoma:        "d026ce3c1616f562b13bf91f09d5da88430e8f83b72a1863486f5606b720fbd1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bee7e09d40ccb5c3327259fca5be0d281b93d19beb8686f3ff71adf9fbf9b16c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d767eba216c69a34604c5fde5e3be7d9cda2619e2c44a6adb4c47deedb7cc722"
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
