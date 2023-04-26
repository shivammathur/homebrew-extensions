# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT83 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4052f11ae84b1706bd60b2c4263d2250562121ab9400c20bf0596e3057dcc53f"
    sha256 cellar: :any,                 arm64_big_sur:  "52d4004ac2b8d988baf326454d7e71ff26ac19d1611480430884957d86a7c8ea"
    sha256 cellar: :any,                 ventura:        "ea92098bf25f6db0286eedfd46d441148303516e0858f18119c03d9f9f27ac92"
    sha256 cellar: :any,                 monterey:       "49518d454c1e6eccfdb55b0b67adde756e5bb109e6ef4c00f563f7ae7d92c66a"
    sha256 cellar: :any,                 big_sur:        "06b9baa028e368a9e24e7238d71388782956af390fbedf47f6825644d8f0f287"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "87d8ca8dc1c21d287a5f8d01ed4e04380e249a30903c202da37d71bae50bc098"
  end

  depends_on "expect"
  depends_on "tcl-tk"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk"].opt_prefix}/lib
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
