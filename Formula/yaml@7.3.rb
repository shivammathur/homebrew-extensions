# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT73 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.2.tgz"
  sha256 "119052f0461d57d86f44c252f9c9b2dd743486c701c1a0aba0aebecdd0d8b82a"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b0024063a2483391336903354e10dd85e445b35816e4b13f57f9dbea816261ac"
    sha256 cellar: :any,                 big_sur:       "b107de1f6beaae57530eb925dc3c3c29072077648b86eeea370bbaf284249756"
    sha256 cellar: :any,                 catalina:      "e5301ec89414f78fd458567507424a4b2badecdcd4c01a8a82f073121ff2ee6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7a3d5417b2c883d763ac70d32f1fabf27ddcf05b94d7cae2547f25b775f098b"
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
