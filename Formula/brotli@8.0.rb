# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "68f8fec3df93eba4aaa25ca9d3b33f13d2c1c8f3ecd127de1b116aa89aa99e4c"
    sha256 cellar: :any,                 arm64_sequoia: "ff65bd172881a562e999fb65b14db2f345ee25ee91bee13ef8bdb263f497cdff"
    sha256 cellar: :any,                 arm64_sonoma:  "fabc6ab5a7bf87d903ff0b407b35996beed79a46e2de96b6a5340f7210e2232e"
    sha256 cellar: :any,                 sonoma:        "f21c6c67eb5ca74902f65e2bccd16bdeac80caf39769e34d5faa43344d2c9d95"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "440d12237c6032dc76f31744eeeb86c1e8fda1dc7fab5e110566034284f970fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c32427edb56731711a7d87b5e56105c8f6a30f613f96c19b8c6493efeb7f8cd"
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
