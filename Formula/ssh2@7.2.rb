# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.1.tgz"
  sha256 "2212d8266df54654b282ca681ee9b82f312a776e801b667b288d80f3541741ed"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "382cb9156fb315b546115e27325ab2f995c9373294bc4d4691283e5064fac6c6"
    sha256 cellar: :any, arm64_tahoe:       "64a3406ba99a7c1c4e3a15d156705dfa5a2496da303859f590bfb65066891021"
    sha256 cellar: :any, arm64_sequoia:     "e7aa618f9bfc9aec7c936354db400ff489103a3a1d3a34585f01fe52e598729e"
    sha256 cellar: :any, arm64_linux:       "f353e838285ddcce71a0c4ff4a95deb3d8c93b04dd1340ff4c5b5311bbd54193"
    sha256 cellar: :any, x86_64_linux:      "2ca63fa16b50965a5d8d1b1cfefbdbf24e3f3ad86edf282ef61a133fc6d4a799"
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
