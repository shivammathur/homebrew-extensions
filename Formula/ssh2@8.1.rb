# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT81 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d04de6298a6555cf733e7cf8c3099d9e1c8b77e2944e7c51d2e4b405d1afd0da"
    sha256 cellar: :any, arm64_tahoe:       "f78da5ece5efff23b1f204f4a006885ab3bbb92a397b1554b5aa72a5d9db859b"
    sha256 cellar: :any, arm64_sequoia:     "eb26153fc1f2d985dc4ea3334f408acd4e94ab7c3a5387408cdd7ad774bd76af"
    sha256 cellar: :any, arm64_linux:       "843f29bb25f5433eb2717e36e15d361c322b9ef814301ca5bdc639aec04c4a43"
    sha256 cellar: :any, x86_64_linux:      "0be1d392f478396e00802963872c66361210464e100a941d76065ab694342260"
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
