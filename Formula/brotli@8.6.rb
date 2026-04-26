# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT86 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  revision 1
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d4360eb6a79339615ad9ad130de75c666be6f7f9eeced64ea3d26527b029451b"
    sha256 cellar: :any,                 arm64_sequoia: "ad17ab55cc982bd3d0db3634be066c67fdfd838c8633ad34fdd7ddfe732668de"
    sha256 cellar: :any,                 arm64_sonoma:  "3a3dbbb90c5b4e0c5743684597011c5346a2266331023baca85a87aa17ab03c2"
    sha256 cellar: :any,                 sonoma:        "67a011ab6847d778cbe1e5667b70317c4fabae7749382b7c105d383de0b04b2a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7faa5f29e96d8fb8db3a62aca9b5aa07a5d3db027d66d2c216ea8d522d0f9dd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5b90ebfcecfb3b2f1a99cd5ebf30783d0c257d148618502be2e71644f9f8546d"
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
