# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT85 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "386afbf0ce4ef44273f65bc68120d4bc9937717263a2392f71eb5866f69d19e6"
    sha256 cellar: :any,                 arm64_sonoma:  "82dd8841a17d2617816663c7c42ab3d01555bcac625f09b2afebde89b8c420e6"
    sha256 cellar: :any,                 arm64_ventura: "0c649ca09e6c7f5e4510dcb76ac7fff3164d49994fd8802f7507f35b3f7815a8"
    sha256 cellar: :any,                 ventura:       "cc2b53f39202f5e5939defdcabceba8fba9d1c09969610b869e553d7ca6e3289"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "530e766a7585c2b9d3a79448c7781de906e3a0ab9871b3423f058865ca55477d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80c4a6f6556fa622a9bfb8b1559b5920af162d14c0096975a137cafeed935fed"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
