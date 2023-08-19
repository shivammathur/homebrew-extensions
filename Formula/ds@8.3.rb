# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.4.0.tgz"
  sha256 "a9b930582de8054e2b1a3502bec9d9e064941b5b9b217acc31e4b47f442b93ef"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_monterey: "314e82a8a54400bb27cd2ca873db6365518eb6fd368df1b86e4f4672b909a9bd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0f98fb79193e35d02973a08a737fa9c5dda4d5efbd45831487466076b1696997"
    sha256 cellar: :any_skip_relocation, ventura:        "0def6c5fbf8e7c45fc582a630f38aef6977d50f70d41935245e1a0d2e724fe63"
    sha256 cellar: :any_skip_relocation, monterey:       "09bfce30b79cb55ced76942fa5aafeefebb0c4d31642d8fd99c5f8b7dab226e7"
    sha256 cellar: :any_skip_relocation, big_sur:        "429c53b9b6f03c511fe48120504141856e74f0bacd2fe877fd4e4d8343d34aa6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3157386b5d5a4829884bfba6679fcdea8a2ac1308803f226599137c5ea4e6fc"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
