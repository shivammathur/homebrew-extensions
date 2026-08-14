# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "cb918960b262f1556bfce80e0f3f0c4761ef579d697ebe6a4d50d7d71331d99b"
    sha256 cellar: :any, arm64_sequoia: "69d21d13b992f220cda054d3077709884b4c34d188d53849680762632d0994bf"
    sha256 cellar: :any, arm64_sonoma:  "0166a0fbdf120369eb69fe63476ce2ac8a5a5ebff81d3d20c76a730464bcdd29"
    sha256 cellar: :any, sonoma:        "cccceaf3eb45b8e21484ccad32beb1a35bce9a745eb7d57c45111b0ecf96cb95"
    sha256 cellar: :any, arm64_linux:   "84f9c38fdfe52894989b32bbf913e02c054d10aa8caa1a0766dda3eb63fdf516"
    sha256 cellar: :any, x86_64_linux:  "2eba72cfd148e4eb6f797de3c25efc81025ba81658635ccc3c31bbdbd007f46c"
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
