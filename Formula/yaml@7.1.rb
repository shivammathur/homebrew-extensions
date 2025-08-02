# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT71 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.2.5.tgz"
  sha256 "0c751b489749fbf02071d5b0c6bfeb26c4b863c668ef89711ecf9507391bdf71"
  head "https://github.com/php/pecl-file_formats-yaml.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "95cbf2b689174f740d652eaed8b1868296e396b741297a4e6c61118fa7cf8c97"
    sha256 cellar: :any,                 arm64_sonoma:  "f0265dd39193182adc4c19951d11bc4fbc81f1b76610873076802bd72c4ee0d3"
    sha256 cellar: :any,                 arm64_ventura: "c6a0e5289e6aa091a5eda3030cb79950385e49b08ea13182f59db8304a2541a1"
    sha256 cellar: :any,                 ventura:       "8204bbcb1375e8aa32aed84eb90e238dc813acc5b93a3d22f23555d832f218e5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cd6784a7296b01c693d2830d4d21f0ab8921577218a2bea354d73e7eb3599b35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c77289984c25f0f2e8bc8cd85eb769a82c7ab4ddb0ab68a1a29a2d8c77346f45"
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
