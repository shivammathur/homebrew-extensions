# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "15c5675e975d3d1acc6a107bf9402c91cd6d3d8705da7f4395871b78e283677d"
    sha256 cellar: :any,                 arm64_sonoma:  "2bbed94db177550d5511c2a2182486e2ab48051f42b46bd0fc5924c1fc527ee4"
    sha256 cellar: :any,                 arm64_ventura: "a4ff0477a669fffb4a6d88ed47e9322d5efc9f7810f7d98fad3d03d0302f3cb9"
    sha256 cellar: :any,                 ventura:       "62b90f25d37055cab15d323ed909117e94480d0ac3722434403221d719a5d1bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba29a262c638b3c978dc830087467eb3d201f9a92674b4c4bedba5fc76161d69"
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
