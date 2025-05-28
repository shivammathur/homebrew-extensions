# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "36240da8c471162887047ca1687e679415051890c0e3b39b21c8472f7b63e738"
    sha256 cellar: :any,                 arm64_sonoma:  "f59de5319a351ae55277df3d503e582fb5469d0bfc0b7238e8bdb61be97686ce"
    sha256 cellar: :any,                 arm64_ventura: "05f02eae872d3983cd1838370ab86f97d064030c210a1fb7017eee7a6579126a"
    sha256 cellar: :any,                 ventura:       "0da6ec310f638c9b47ae82220c1c4cee1e94654eb196cc10cac611009f4b1c24"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c3eac6559df7a721660c7a07b5ed01a24b183e386150c4e52bf296daf95d859"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "58ed9d9372f1f111c4729c5b73c4d6ebcc58ccc2fc751d32c2a8ef54cb33f1cf"
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
