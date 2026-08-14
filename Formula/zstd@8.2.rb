# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "2261215f4c14496aa714a01a86a5fe3b71ffd99622b016866c7a5b3d0ebb8569"
    sha256 cellar: :any, arm64_sequoia: "88f84c70b2ab4db55b6d40d4569de011f28a761b4bb601690ae9f571a19e34d5"
    sha256 cellar: :any, arm64_sonoma:  "a195aa6b95e91d6c55bae44131c02f8d0da300230b1555255eb667e2237ce3c3"
    sha256 cellar: :any, sonoma:        "72e4ee2d8c48e4c62a770cfdad82972d132878bc38d56fd5d72b98c844a22271"
    sha256 cellar: :any, arm64_linux:   "86b4e007088849067be88bc17d76ab30bc4abbffe16a075379c69a5fe9b3b1a9"
    sha256 cellar: :any, x86_64_linux:  "5cf8edfecc20f5ed2c660c4031650fb49e0f2205cf61de97ca86ec9d983d2c95"
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
