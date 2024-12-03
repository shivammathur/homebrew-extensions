# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT82 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "37ef35bbbe242ed30532d716b5529e280bd9041bc08ea4362c213f63a9955613"
    sha256 cellar: :any,                 arm64_ventura:  "0f8bc7084234d4571addb590f240e4e055ea173320cbbd49ec14ee3d64fe1f96"
    sha256 cellar: :any,                 arm64_monterey: "8a758326ce31780ad2b463afa8176d21047ff481c09263064ad4287b77af99ae"
    sha256 cellar: :any,                 arm64_big_sur:  "041b93474417ad82a90ee10c300e34af5462b1b0bbd4150b4630d1bfbe6ce084"
    sha256 cellar: :any,                 ventura:        "7be8c9dfa5ecfb83a20a16af201054531034504e50d515d5e39533e954a41e9a"
    sha256 cellar: :any,                 monterey:       "9c1fae2ccf75b4b5dea4116fdc783d8c8327b23bd1558dcbde82b2ae0b4a72fc"
    sha256 cellar: :any,                 big_sur:        "847b11cefe40c9b45776f3f4d4adfa8fa68f2cc718e47dcc4516af17e2893a41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6848f5cfc66d080f127efdd05f91d7a7b5f30e249fb42e9eb1f17e28354d622e"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
