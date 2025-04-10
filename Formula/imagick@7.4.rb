# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "b57552fc63e760b3be42cb124d418789be028f91bbe5df1a590603f69aaeb3ca"
    sha256 cellar: :any,                 arm64_ventura:  "883f7146cf5dbd04b6058b5a32bef44d9cbfb6c46c6f1991c470e4b2e25e1f5d"
    sha256 cellar: :any,                 arm64_monterey: "f69c1f8d40bbd62caef9cff08dbff20807852f1646b45deab52c0e018e143383"
    sha256 cellar: :any,                 arm64_big_sur:  "bba39891a84d265aaeee785ff5d032af04185f75439850d1827aee9eba3b6c43"
    sha256 cellar: :any,                 ventura:        "8db18cecee36bbaaf58043b6d25791f111405a199e9612bf17d9ae6d96b8b8c9"
    sha256 cellar: :any,                 monterey:       "fdcb5b7f0598155f4dd21d833b65dfa91bb7a4c26fb8e656c22aeb7bb234d078"
    sha256 cellar: :any,                 big_sur:        "244b80ca7175b8866a2a9dcf7a3202489fd5c181b2cb23cb6b73e1fcfa4c1005"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8a273f44ba69d71b72a69e9e316603206b5905b04d7cf9f2c579e6c6c1b8030b"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
