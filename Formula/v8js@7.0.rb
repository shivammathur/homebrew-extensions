# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT70 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_ventura:  "70acfd7c76cd7441f9879a8dc4c5f9d21c8950f4b5cad8b1c229b87149e29695"
    sha256 arm64_monterey: "25073835dd076122c54ec1cbb20f89c5b296dee3ee4e340fb5a594aa28eb0540"
    sha256 arm64_big_sur:  "b5ca5b61eb8d3cb9ad1714eef3eddd7d9251c5d3e4fadbf103ef5c91e293e5af"
    sha256 ventura:        "2a2f70d3c1e9f1e255069c5c26775eda314d3c98437f3b00436490aa71f3ed24"
    sha256 monterey:       "af9765303022e42fc6ea0fa1463c18b1b734254829479d0cf0fe6b2e3283e82f"
    sha256 big_sur:        "e137cdbbab99b5dd5e85f7545667dd344df192777a14745654aa6ead9a2ed891"
    sha256 x86_64_linux:   "b9cb21684d44109c7dc8ed931e48b3500aec264c9562713ec646dc39fd70bd6d"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing -Wno-deprecated-register -Wno-register"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
