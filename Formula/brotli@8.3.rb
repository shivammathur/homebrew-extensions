# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT83 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5dd958238225cb10870bc000fecb11de1f2dd353db44515b688f422cb4c3aab8"
    sha256 cellar: :any,                 arm64_sequoia: "dd5bcd264e766cdcbac95c5369f28b601ead4344a146e5b18ec702e269ecc50c"
    sha256 cellar: :any,                 arm64_sonoma:  "0b0b3bad678ace37299f411d8d18d89703bd0c49a09b5175a44c6bdf798d7c67"
    sha256 cellar: :any,                 sonoma:        "90ff9fe4a6631a5afd289a3a81657414172da0c2b229e199842cf2f44ead8e51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e51a53c9c57916db20ed6df81bb62c5eb040cedd005186e5a6fc4526ed6bccb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "81b3599a42d477328e80f4288481ba73489c96e25125ae73fae9e2c615035212"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
