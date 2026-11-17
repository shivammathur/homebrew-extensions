# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "712b137adeb065524d577b5c974153066f7d1cc1da7e66cda4fc1e33cfbb9b51"
    sha256 cellar: :any, arm64_tahoe:       "47584b6f8ac8d1a605aff9c073c5afa1ca0057d876a6deaf9fab69b85dc0fb03"
    sha256 cellar: :any, arm64_sequoia:     "656ee01c628943f813438a041657d43536be49b9ed07d90b154294989601f564"
    sha256 cellar: :any, arm64_linux:       "7c61bd92ee8a0ce45c584948e9bf521d7ad174728789a55f8fcc04a523127cb0"
    sha256 cellar: :any, x86_64_linux:      "59d6887925d0139654bfd5c8cec00c5ce3ae55a7ad3b92dbd147c4ce6dabee9d"
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
