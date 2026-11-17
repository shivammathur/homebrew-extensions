# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "e90b055b455a817404be1380fa38269bea731e3efbb2f1d30ef8dd466c532a01"
    sha256 cellar: :any, arm64_tahoe:       "a3e67c77f569f56c2ba66b22def50a53c3410e08baf2f33a0cfd0a2e82747f35"
    sha256 cellar: :any, arm64_sequoia:     "e6f82723901501b4543583290fe170bfbb055f33505ac0238fe69b258fc44b2d"
    sha256 cellar: :any, arm64_linux:       "afa6c9cf745cecbffde4ef628f2a4e64f5b0b1473f0cd4c60e506d63000f6807"
    sha256 cellar: :any, x86_64_linux:      "ddf47d93f1bb585766fef6953760c6c063a984ae221b6b11d4ab6f1b70534ec8"
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
