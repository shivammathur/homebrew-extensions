# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT87 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "44597fd56bd1a46cee238b6b14767d52dba53254e1e75e271f50fc77b7e48d21"
    sha256 cellar: :any, arm64_tahoe:       "1f077d6dab2b181e6f3a88b15ae026eb0b0d373b7662f0b34c6a79381463a119"
    sha256 cellar: :any, arm64_sequoia:     "c18bb14628ee6bcc2880066831264ac8302b0ed8491b5394d83b2638d0197bfa"
    sha256 cellar: :any, arm64_linux:       "9c4cc75b0957233bd2d449dda886f92a673a3eb46bb823ef851bd498b44f57bd"
    sha256 cellar: :any, x86_64_linux:      "2cd53aef8fd5e2120bbf89422cb4621a6b7a3804cd75b06ec0c7c63553efb465"
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
