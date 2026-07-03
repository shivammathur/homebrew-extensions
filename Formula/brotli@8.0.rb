# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT80 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.20.0.tgz"
  sha256 "e8d303afa3df0afc4e1362496482e3d20052b3bb478027b597073c8114d1f2ea"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "0bdd4a9764c6ccd1986137a788ab11284a8af0ddee73ffb8b7d598569da7c407"
    sha256 cellar: :any, arm64_sequoia: "fb0642fff40a242af1ea6fa17e87fa2b1cba75cf943527975e855dd9bdb5f6f3"
    sha256 cellar: :any, arm64_sonoma:  "d048c8e32ce465b8fee4b793b3089a6c4db9a278435a82b5316485d1a612de4f"
    sha256 cellar: :any, sonoma:        "8856da7247d046d70d696392ddd63b281744c423c60bd5afc992d258ae02a64a"
    sha256 cellar: :any, arm64_linux:   "27ba2ba88f69d50640415db3fa521524bffe04a4b71b66d211d47ef07d8fc1e7"
    sha256 cellar: :any, x86_64_linux:  "07ae2c5e5b5caaf0721f1a6deb11fb56c8d7e16197785841ef1af85c0796a4a0"
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
