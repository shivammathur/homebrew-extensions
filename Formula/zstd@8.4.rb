# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.0.tgz"
  sha256 "cd8bb6276f5bf44c4de759806c7c1c3ce5e1d51e2307e6a72bf8d26f84e89a51"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "164f7cf4049cfebe09196d57d0deed0f7ad36140ca2187c138ef80b8dbf0144c"
    sha256 cellar: :any,                 arm64_sonoma:  "c1a089388c150c0128c573f1603d1a08ba6f7576d75878e8c4966714b8987652"
    sha256 cellar: :any,                 arm64_ventura: "3a41aba1aab06825ce1485d94bcae72adc61ac254a5bd217adde2d9b03d86214"
    sha256 cellar: :any,                 ventura:       "bef79f8af8bec9ac8c06ddabb4eb66b1ac0d07bb0337e98e4208600608a93545"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc4293898dc289b7730b71f380879582dfcc719e038c36105990e0effa4417e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4cd6ba52d8fc9c4571651aafb52aa1627eb6b743c67008fb1552bc215087075"
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
