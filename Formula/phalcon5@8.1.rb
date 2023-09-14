# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.3.1.tgz"
  sha256 "3a3ecb0b46bc477ed09f8156545fe87858f0e31ea55ca6110cda4594c234fb3a"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e5e4f7727e3157fc72f87cdaa18ae5577167ef2842bf6580bb4c19b18953b8c8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "04adaf3104315f82b88ec75c0cd12c11117b351fc6f5cc6e896b163e401fea43"
    sha256 cellar: :any_skip_relocation, ventura:        "67c08de25db978672b66b43b560e1dbc23d329e27891fa2767924da95d1e84ab"
    sha256 cellar: :any_skip_relocation, monterey:       "8e8e29be00b44973cac6aa75d853964bdacc71ec55656d652cb94b29d4819754"
    sha256 cellar: :any_skip_relocation, big_sur:        "a6b8823704355e019e96f62bf62f2c44149e81b5253ff5743f718342fcb4bb3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01193c2c5fdd35eafc238edd8082b97ca27056cf57c05cbfada1acc837ace506"
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
