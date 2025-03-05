# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "3855effb8f479514b62e53148f8e77dc2c01702245320fc69d5436d976cc7c1f"
    sha256 cellar: :any,                 arm64_sonoma:  "3cf5c8e568182094b5947442924e8d46093452df9608145218df6dd029696a23"
    sha256 cellar: :any,                 arm64_ventura: "317283f1a976bfc60de122136e6ea699e35b251b26b68d94836a23fe0f6c54b5"
    sha256 cellar: :any,                 ventura:       "c76265ffd682fdd99e01d7f9cda06f3a4d22e61f7988c3a99b1b3c488ad09693"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "064300cbe84acca81506b1aea75545a3329f83a0376af71f1f26dbf07c1f9e66"
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
