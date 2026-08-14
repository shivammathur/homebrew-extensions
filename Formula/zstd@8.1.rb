# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT81 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.18.0.tgz"
  sha256 "223d0f77eb5a5e73cf5e7a0652dd8fde7ffdcc843e7f30eeb3998283dec847b9"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "5887e400c5751f3cd570923e2ec4e9513519615cfa7e6c66de6c57e2ba066750"
    sha256 cellar: :any, arm64_sequoia: "3fd060d8e29a7babbd9ea0ed319b22a0f899b8205c27d9f0feaf96e047a7e34c"
    sha256 cellar: :any, arm64_sonoma:  "95338a8f18e0437edc25ec34b8b8bf050a48606dc0c9b4b4f01727494c81b9f4"
    sha256 cellar: :any, sonoma:        "7500ab005df4727f8a57e627db34fff95eba79b26ff37a773a9e1924e8501a89"
    sha256 cellar: :any, arm64_linux:   "bfc3e103448e90f42a3c344555943c711df1a4ab9ff955ee2358dc0c32816bd1"
    sha256 cellar: :any, x86_64_linux:  "90f7ed57d5218766c514f5f5b760a44fb50d9a18715cd01898210c91dfe7c64d"
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
