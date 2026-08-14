# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT72 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.0.tgz"
  sha256 "97a69edd4f71046b1bd285d914741a60478e69a1db785c2b42aed940ab1fa18f"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "0a33694f499b23660d9b2095ebb05f77a1b7555b3109fa22e3af393a18f758a2"
    sha256 cellar: :any, arm64_sequoia: "7f4acf6b53e5351ff9c75e76b0d7951e658ccf0710a5b551302e5fb31e36f4b9"
    sha256 cellar: :any, arm64_sonoma:  "11e4dbcef3976836ac904a8c5806fbdfeb75cc9c9e1c7a01cbccd02830678a2b"
    sha256 cellar: :any, sonoma:        "64df04b70d900aa43b152bde702d8373f52c0d1b6b7d9ad1ddaa76a26615b7d8"
    sha256 cellar: :any, arm64_linux:   "5aa5c538aa7a169cccf9bb921dd5a4f17d20be5161d7bd63d23aaa08e7674580"
    sha256 cellar: :any, x86_64_linux:  "c216ce1a82bd58a369bbc9fa20606232412a79af7ad30742e71a23c5f1bc30df"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
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
