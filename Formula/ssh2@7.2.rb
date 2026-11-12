# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_golden_gate: "6fbea6dcb99eadd266487d38162e1716ffb0589bc3c509518f7e980d0d9903c1"
    sha256 cellar: :any,                 arm64_tahoe:       "c3c9ddb936d094a64b49365a4a2aacb28f0a288b3872557d4f9cee9bfea6914c"
    sha256 cellar: :any,                 arm64_sequoia:     "a000f475f1645d7fb76aaee0d518c03d56359c344a80e27ebe26b75bf720a07b"
    sha256 cellar: :any,                 arm64_sonoma:      "a6a42fec510bf4611277f89938c7540a415132d6b8e0b896669ca2e38ca295fb"
    sha256 cellar: :any,                 sonoma:            "d4a2397f85f2d28b09115d35ecfe0b6889c9924874ead35cebc4eb33f182b7cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "e486b3b2a35a611b3909fe764153e05c43a84bd46b3ed50cbaf4c3e2195103ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "301a15c3e7a1af29b33e409b46d1fc7b1ad64c7b43a605e6c4511659fb352c55"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    inreplace "ssh2_fopen_wrappers.c" do |s|
      s.gsub! "ZSTR_VAL(resource->path)", "SSH2_URL_STR(resource->path)"
      s.gsub! "zend_string_release(resource->path);", "efree(resource->path);"
      s.gsub! "zend_string_init(path_in_original, strlen(path_in_original), 0)", "estrdup(path_in_original)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
