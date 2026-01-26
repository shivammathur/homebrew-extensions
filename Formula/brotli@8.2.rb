# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "22aba8125e7d069073d7efd0390ec9abfaf9010e21f865c9911af2a65650ea61"
    sha256 cellar: :any,                 arm64_sequoia: "b3684684d6af36c3be9866ea1a8f2d7438764e774bc3b67a5cf0f9f71e90493c"
    sha256 cellar: :any,                 arm64_sonoma:  "9b78ad26da8b4fac3c49ffdb6e001961647eeef136b9676a3944ae58532f391b"
    sha256 cellar: :any,                 sonoma:        "df8c3f103c89d4243df212c0d637b373af720dccb2c805691e67cafc9e22acb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c67ab81b2de5b064aa13072e144b72421a61d9a5775461a5826afa6638535b8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "605ed129b3f56198283b04de0e9a8ce559165bdb93b4707bc232f73e5b05a58b"
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
