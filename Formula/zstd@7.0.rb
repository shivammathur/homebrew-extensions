# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.15.2.tgz"
  sha256 "fd8d3fbf7344854feb169cf3f1e6698ed22825d35a3a5229fe320c8053306eaf"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "aca80f178f876a530f69ef88c54f40049dcfd4564ba6c6f0afa0c7d61d0850ba"
    sha256 cellar: :any,                 arm64_sonoma:  "86f8e277624eee4b9b96715f31b4b8c7848bd9c13b61ff1f7f0d3f39c72cfbbc"
    sha256 cellar: :any,                 arm64_ventura: "3cdc1cb10aee48c33fd89c4efda0e54540ce36df138fcaeaa9b34c271936e42f"
    sha256 cellar: :any,                 ventura:       "99969641fbe72034f14029777178fd80fe323f4eda3f395f127ee0b2fc5a85a8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad4579ceecf738dd005a7823ef12d465aca1e5c02bccb8920276e6767b0244bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74dfd6940fab177b012372d3b52ae61bf831eaae0d5d7feedf16770a3d14c1d6"
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
