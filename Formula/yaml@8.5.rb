# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT85 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.3.tgz"
  sha256 "5937eb9722ddf6d64626799cfa024598ff2452ea157992e4e67331a253f90236"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "241a44ed517b4ab6e7aa8ab0cc44c136b94d08268fd6d619e499734c87a66a3e"
    sha256 cellar: :any,                 arm64_sonoma:  "1665bd2666e2b9b1f37685e23c812d190112b734e6c9b2412956df96cd0a7402"
    sha256 cellar: :any,                 arm64_ventura: "e4351bdee7cf36df6ab37cb1a854a321843b73333a083458aeb3cd920013d038"
    sha256 cellar: :any,                 ventura:       "0b39943d9b61f22a3bb29c98ccddc8b5d7d850f2da834932dc74c956a5e2a2eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5c2f7fae090646cd1626ec1fe57894b9eda69932d51bb3f33fd329e5703476ca"
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
