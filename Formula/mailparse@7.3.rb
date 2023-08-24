# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cb819c504ee11f5bbef2d22957227c8770a2fd1d3cb6bae2c957497c459647e0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e411efb0f9d857b91e5a9b82d2244a035ad3a17a663f607ee9cec74ff12773ea"
    sha256 cellar: :any_skip_relocation, ventura:        "3929a08de96ca9a4c7cca2fbc919ff583f1906934dab3735539be01efea16441"
    sha256 cellar: :any_skip_relocation, monterey:       "391029a6b037e02b1edf85dfe1dcb2fe232ff7d1f3211d51b7d6d329bef8a2f7"
    sha256 cellar: :any_skip_relocation, big_sur:        "890212784785d6c66ff27a461f65fc9f8e9680082f5e334f157a7eedbd0b5fd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bf5f4ea139231c58adbacb083df932d1f9d6e3343f5e153e0f8d3d79e6abcee"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
