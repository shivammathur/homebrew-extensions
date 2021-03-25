# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.8.tar.gz"
  sha256 "f67a1c1aabe798e5bb85d0ea8c7b1d27b226b066d12460da8d78b48bfc6f455e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "881c09be700be755919422c1a638b3da93a69e7c063daebaa6a0d9c3062bf600"
    sha256 cellar: :any_skip_relocation, big_sur:       "804840abeed9532455bb96b5f00b3a3167f1cdba8bd7fda91c2e5aec4ee84ea2"
    sha256 cellar: :any_skip_relocation, catalina:      "b729f8f49ed62a5d948fa2b384605f45f981b87f1e95193148cd2995832f1053"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
