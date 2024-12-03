# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT74 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.4.tgz"
  sha256 "8eb353baf87f15b1b62ac6eb71c8b589685958a1fe8b0e3d22ac59560d0e8913"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6a46b991a8682b5c62edc41de7b0a405eb06b89fc7612f362d26591c1f50e068"
    sha256 cellar: :any,                 arm64_sonoma:  "f021c7fc7a941d011124f5ff9379fdce82ac0d76a1212917b90d566a2ac467f4"
    sha256 cellar: :any,                 arm64_ventura: "f3e28c7eb84e96bf92a3215e2621156105d07102483222db7934f11005ea3032"
    sha256 cellar: :any,                 ventura:       "5f6c0a791aae61b44981355e31615d3d9f81334a6b197348288666974c04bac7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dd055a721442043bbe63fec3c28cf6ee02b5d759aaeae4edef2bcc5538f2b41"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
