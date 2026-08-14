# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "41e633ab081e21ce2b8b49b223ecdf434fdb2b4f88994ea86cb737e02e22ecfd"
    sha256 cellar: :any, arm64_sequoia: "d355c3bc71899fd22f6c2baefdbd555f3c6bffae3719e4bebe82b184836f2c9c"
    sha256 cellar: :any, arm64_sonoma:  "a307bcd428b1637841b2d8971f2ca06029433830dd8c0633cb3a2dd1990fa3c1"
    sha256 cellar: :any, sonoma:        "d853b3681c46fcde4143023ee493e835b6f916bcd4a3ccd35f0916a0aaddaf02"
    sha256 cellar: :any, arm64_linux:   "7bb3c07286f8e6a445778a8e3eeaea1f33ca5b344014ddfb008110b867dd534e"
    sha256 cellar: :any, x86_64_linux:  "7b52685a8fb3e822c670b93635ae0353052527218472ae7a2384542ece9ee75e"
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
