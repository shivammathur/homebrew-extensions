# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT86 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.17.0.tgz"
  sha256 "38cf9e239e72e775bdf01fb5f1abaed76c7ce92e8d3a562a97ef96c9d0446ea0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "7078e2ca71975407fbb738aef83d592e1055e0ac3b6532544b1e09bbf297a567"
    sha256 cellar: :any, arm64_sequoia: "7f877c46b8c64ced15c64227931a5c1a699403d31990c1b43d00177328ffc23d"
    sha256 cellar: :any, arm64_sonoma:  "298d5facf82790648a7f82fc5c503d97032c49d466a7159826b5731f4179bc43"
    sha256 cellar: :any, sonoma:        "609f8f04f23c93dfd62cb6b6ae7bfebd42b00e3ab038ddc8dc043739d228b336"
    sha256 cellar: :any, arm64_linux:   "1aa6980e81e1e579e9b34be9f1371a53db98ab4111037cf1d29377563d39f9a2"
    sha256 cellar: :any, x86_64_linux:  "ba01b6337d39977eb6aab27bd2fb7179bba55d3c29dae6a89b24fb8a8feb70ea"
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
