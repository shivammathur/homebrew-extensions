# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.21.tgz"
  sha256 "1033530448696ee7cadec85050f6df5135fb1330072ef2a74569392acfecfbc1"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a3845cff3a94f7f2e1f9ae78a78846dfba01c8df4fc65450407f203639826a48"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d76c8fcfb52b638e6f0969626bb15329d1715289c7327c7e846ba22c983e512b"
    sha256 cellar: :any_skip_relocation, monterey:       "6606f9bac8bf54fcf436cc7ef5c50f7765003ea1933db71313bb1c7ce4860008"
    sha256 cellar: :any_skip_relocation, big_sur:        "96d2f0d7b85d5ad84509c2317e2cd45181660b5700af8bb95432abc5adc946e5"
    sha256 cellar: :any_skip_relocation, catalina:       "be7183cc64548b99b54d885ef29edd3d7beb85d03e219703914809057b32ebd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12b07f93a22c2c6af57105337ff3c732ddce6e37d59727e502edaffcc38f60db"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
