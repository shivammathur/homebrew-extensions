# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2c874af4f8a8470f17779803a87e0d4e8dfa1a2da934cb7289217dcd35e2c158"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "147262e700e94a83a5018dc5a5bb3cfdba3ff3f3b5502073ad11469729fca781"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "03333263e83af1185fcecb52eebdd6cd59dc37695aa9394e3009db06b8483234"
    sha256 cellar: :any_skip_relocation, ventura:        "13374ca3f8777b8000e9a2b63089744a48a0578498392d1e5fc595b7bce84a4b"
    sha256 cellar: :any_skip_relocation, monterey:       "30ef76ba6d2ae8d1a1c36839a3368b39754f080981225d11b092f3fd33940f16"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3411eb6e75b33b1dc823acea6140fd415cbc38e906f16fc397901884f86845d2"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
