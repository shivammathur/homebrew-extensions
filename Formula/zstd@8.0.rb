# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT80 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "b9932278434c1cbcbbdaa706194a02f309a90630f688981ef6eeb1fe670e0808"
    sha256 cellar: :any,                 arm64_sonoma:  "d441d2570e52f39f41bd42ed455609a6ab66ea6db41bbf0c053796afc525de69"
    sha256 cellar: :any,                 arm64_ventura: "235c8fe98e8eea301b0ad93cae2790eacc93a87f29a0469debcb698bd3d0e6a3"
    sha256 cellar: :any,                 ventura:       "8d3ececdb789b9afcc4e5451285acfaede181123bef375c2a48ef32d8fc3907d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3fd95baca63a7bbd4cb67e1acb6bc9e93f8b525f71daa641bb05b0352efbe156"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
