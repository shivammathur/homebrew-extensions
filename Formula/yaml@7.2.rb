# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT72 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "c3b1206e4bf25b6443792936068d98bb7b441e2cabbd71674d81b2cf6d3e3ab9"
    sha256 cellar: :any,                 big_sur:       "659879872ec2620b5a55fc7ea793bc0bea732f9ee77883642106c904119e3bd1"
    sha256 cellar: :any,                 catalina:      "912508deb971e972d764f19459cac6e8df963207c3a0e008e9f78733e58110c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f91cd7677a8aac4b5657947b4e1ed8073ae4063d6a9ad2ba83906eacacc57248"
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
