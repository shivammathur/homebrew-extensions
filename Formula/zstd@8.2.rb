# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.1.tgz"
  sha256 "5dd4358a14fca60c41bd35bf9ec810b8ece07b67615dd1a756d976475bb04abe"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a02ec03ebc730275380a4fe6ff2aed928f3b4e45ea7dc19c8ecec5e249abba2d"
    sha256 cellar: :any,                 arm64_sonoma:  "380b305f5fcfb7d63fe2774654e096da008ce7523fe3bd56fd0830d772ed8100"
    sha256 cellar: :any,                 arm64_ventura: "b55fba5176a866cf72edfc17c5dc18de88f9f1319c99d750fbf2659cb2310518"
    sha256 cellar: :any,                 ventura:       "bb91aa3c9910835766967f132a7f24fc6b33f86e4b3eb8a88f668a3bb64eef7b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d17dcd3f925c470fe857d918d9e0b2fabdb0ca8a5aea48efca406851bc0d59f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a053247a658d1e1ee4e676a5f57fd9d8abd9519c30a946fbcb1219a3e92358ec"
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
