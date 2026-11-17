# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT82 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "12660302f08659dc4c632adb70c5fde6c2df1b586f2d1bcb4988743535fd6283"
    sha256 cellar: :any, arm64_tahoe:       "8e9533cdd8822967c7456144b7af4d305729d190c026e7da8048191ce2b0cb81"
    sha256 cellar: :any, arm64_sequoia:     "e9b3be3b9f84b62ee8d04d7a587f6afcab9fb5add73be16d50b8fc038361e2d9"
    sha256 cellar: :any, arm64_linux:       "cdf8be667e6a34b566624f8a04bdb48873bb834a986ceb9ffc93e71f26239332"
    sha256 cellar: :any, x86_64_linux:      "04b28a21a9d356cb80a35d8cb653f4ec210737ce3749872f47ff59205ebe885e"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
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
