# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e685cfb3beafbf44538f96dba5c092163487d6c8414f58e008e4696240b927db"
    sha256 cellar: :any,                 arm64_sonoma:  "99af7fc70fae59e6de8a8e62b859b2e2f4e45eb570a16b42e7a29b316bb2b7e2"
    sha256 cellar: :any,                 arm64_ventura: "04e9f4df9dcfe9a39f9a4aacb6f490bdfd741d510fb4feb2ed8657fcdca36e2e"
    sha256 cellar: :any,                 ventura:       "ea1a400c270ee76c21253efcf6d275cd106467ca25d9c20f89fc153fad31aab7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8934bf143ee0f9807a8b96c8883e1126e705eb217ec2a8b517553f117da47a18"
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
